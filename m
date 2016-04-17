From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH V1 4/7] mtd: nand: add Loongson1 NAND driver
Date: Sun, 17 Apr 2016 21:38:47 +0200
Message-ID: <20160417213847.21bfb49c@bbrezillon>
References: <1459946095-7637-1-git-send-email-keguang.zhang@gmail.com>
 <1459946095-7637-5-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1459946095-7637-5-git-send-email-keguang.zhang@gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: linux-mips@linux-mips.org, linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, dmaengine@vger.kernel.org, linux-gpio@vger.kernel.org, linux-mtd@lists.infradead.org, Ralf Baechle <ralf@linux-mips.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Keguang,

On Wed,  6 Apr 2016 20:34:52 +0800
Keguang Zhang <keguang.zhang@gmail.com> wrote:

> From: Kelvin Cheung <keguang.zhang@gmail.com>
> 
> This patch adds NAND driver for Loongson1B.
> 
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>
> ---
>  drivers/mtd/nand/Kconfig          |   8 +
>  drivers/mtd/nand/Makefile         |   1 +
>  drivers/mtd/nand/loongson1_nand.c | 519 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 528 insertions(+)
>  create mode 100644 drivers/mtd/nand/loongson1_nand.c
> 
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index f05e0e9..d90f545 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -563,4 +563,12 @@ config MTD_NAND_QCOM
>  	  Enables support for NAND flash chips on SoCs containing the EBI2 NAND
>  	  controller. This controller is found on IPQ806x SoC.
>  
> +config MTD_NAND_LOONGSON1
> +	tristate "Support for Loongson1 SoC NAND controller"
> +	depends on MACH_LOONGSON32
> +	select DMADEVICES
> +	select DMA_LOONGSON1
> +	help
> +		Enables support for NAND Flash on Loongson1 SoC based boards.
> +
>  endif # MTD_NAND
> diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
> index f553353..0310c0b 100644
> --- a/drivers/mtd/nand/Makefile
> +++ b/drivers/mtd/nand/Makefile
> @@ -57,5 +57,6 @@ obj-$(CONFIG_MTD_NAND_SUNXI)		+= sunxi_nand.o
>  obj-$(CONFIG_MTD_NAND_HISI504)	        += hisi504_nand.o
>  obj-$(CONFIG_MTD_NAND_BRCMNAND)		+= brcmnand/
>  obj-$(CONFIG_MTD_NAND_QCOM)		+= qcom_nandc.o
> +obj-$(CONFIG_MTD_NAND_LOONGSON1)	+= loongson1_nand.o
>  
>  nand-objs := nand_base.o nand_bbt.o nand_timings.o
> diff --git a/drivers/mtd/nand/loongson1_nand.c b/drivers/mtd/nand/loongson1_nand.c
> new file mode 100644
> index 0000000..28f7ca7
> --- /dev/null
> +++ b/drivers/mtd/nand/loongson1_nand.c
> @@ -0,0 +1,519 @@
> +/*
> + * NAND Flash Driver for Loongson 1 SoC
> + *
> + * Copyright (C) 2015-2016 Zhang, Keguang <keguang.zhang@gmail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/nand.h>
> +#include <linux/sizes.h>
> +
> +#include <nand.h>
> +
> +/* Loongson 1 NAND Register Definitions */
> +#define NAND_CMD		0x0
> +#define NAND_ADDRL		0x4
> +#define NAND_ADDRH		0x8
> +#define NAND_TIMING		0xc
> +#define NAND_IDL		0x10
> +#define NAND_IDH		0x14
> +#define NAND_STATUS		0x14
> +#define NAND_PARAM		0x18
> +#define NAND_OP_NUM		0x1c
> +#define NAND_CS_RDY		0x20
> +
> +#define NAND_DMA_ADDR		0x40
> +
> +/* NAND Command Register Bits */
> +#define OP_DONE			BIT(10)
> +#define OP_SPARE		BIT(9)
> +#define OP_MAIN			BIT(8)
> +#define CMD_STATUS		BIT(7)
> +#define CMD_RESET		BIT(6)
> +#define CMD_READID		BIT(5)
> +#define BLOCKS_ERASE		BIT(4)
> +#define CMD_ERASE		BIT(3)
> +#define CMD_WRITE		BIT(2)
> +#define CMD_READ		BIT(1)
> +#define CMD_VALID		BIT(0)
> +
> +#define	LS1X_NAND_TIMEOUT	20
> +
> +/* macros for registers read/write */
> +#define nand_readl(nand, off)		\
> +	__raw_readl((nand)->reg_base + (off))
> +
> +#define nand_writel(nand, off, val)	\
> +	__raw_writel((val), (nand)->reg_base + (off))

Are you sure you want to use __raw primitives here? What about
endianness and memory barriers? Is it safe to skip them in your use
case?

> +
> +#define set_cmd(nand, ctrl)		\
> +	nand_writel(nand, NAND_CMD, ctrl)
> +
> +#define start_nand(nand)		\
> +	nand_writel(nand, NAND_CMD, nand_readl(nand, NAND_CMD) | CMD_VALID)
> +
> +struct ls1x_nand {
> +	struct platform_device *pdev;
> +	struct nand_chip chip;
> +
> +	struct clk *clk;
> +	void __iomem *reg_base;
> +
> +	int cmd_val;
> +
> +	char datareg[8];
> +	char *data_ptr;
> +
> +	/* DMA stuff */
> +	unsigned char *dma_buf;
> +	unsigned int buf_off;
> +	unsigned int buf_len;
> +
> +	/* DMA Engine stuff */
> +	unsigned int dma_chan_id;
> +	struct dma_chan *dma_chan;
> +	dma_cookie_t dma_cookie;
> +	struct completion dma_complete;
> +	void __iomem *dma_desc;
> +};

Please separate the NAND controller and NAND chip information in 2
different structures. See the sunxi_nand driver if you need an example.

> +
> +static void dma_callback(void *data)
> +{
> +	struct ls1x_nand *nand = (struct ls1x_nand *)data;
> +	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
> +	struct dma_tx_state state;
> +	enum dma_status status;
> +
> +	status = dmaengine_tx_status(nand->dma_chan, nand->dma_cookie, &state);
> +	if (likely(status == DMA_COMPLETE))
> +		dev_dbg(mtd->dev.parent, "DMA complete with cookie=%d\n",
> +			nand->dma_cookie);
> +	else
> +		dev_err(mtd->dev.parent, "DMA error with cookie=%d\n",
> +			nand->dma_cookie);
> +
> +	complete(&nand->dma_complete);
> +}
> +
> +static int setup_dma(struct ls1x_nand *nand)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
> +	struct dma_slave_config cfg;
> +	dma_cap_mask_t mask;
> +	int ret;
> +
> +	/* allocate DMA buffer */
> +	nand->dma_buf = devm_kzalloc(mtd->dev.parent,
> +				     mtd->writesize + mtd->oobsize, GFP_KERNEL);
> +	if (!nand->dma_buf)
> +		return -ENOMEM;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +	nand->dma_chan = dma_request_channel(mask, ls1x_dma_filter_fn,
> +					     &nand->dma_chan_id);
> +	if (!nand->dma_chan) {
> +		dev_err(mtd->dev.parent, "failed to request DMA channel\n");
> +		return -EBUSY;
> +	}
> +	dev_info(mtd->dev.parent, "got %s for %s access\n",
> +		 dma_chan_name(nand->dma_chan), dev_name(mtd->dev.parent));
> +
> +	cfg.src_addr = CPHYSADDR(nand->reg_base + NAND_DMA_ADDR);
> +	cfg.dst_addr = CPHYSADDR(nand->reg_base + NAND_DMA_ADDR);
> +	cfg.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	cfg.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +	ret = dmaengine_slave_config(nand->dma_chan, &cfg);
> +	if (ret) {
> +		dev_err(mtd->dev.parent, "failed to config DMA channel\n");
> +		dma_release_channel(nand->dma_chan);
> +		return ret;
> +	}
> +
> +	init_completion(&nand->dma_complete);
> +
> +	return 0;
> +}
> +
> +static int start_dma(struct ls1x_nand *nand, unsigned int len, bool is_write)
> +{
> +	struct mtd_info *mtd = nand_to_mtd(&nand->chip);
> +	struct dma_chan *chan = nand->dma_chan;
> +	struct dma_async_tx_descriptor *desc;
> +	enum dma_data_direction data_dir =
> +	    is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
> +	enum dma_transfer_direction xfer_dir =
> +	    is_write ? DMA_MEM_TO_DEV : DMA_DEV_TO_MEM;
> +	dma_addr_t dma_addr;
> +	int ret;
> +
> +	dma_addr =
> +	    dma_map_single(chan->device->dev, nand->dma_buf, len, data_dir);
> +	if (dma_mapping_error(chan->device->dev, dma_addr)) {
> +		dev_err(mtd->dev.parent, "failed to map DMA buffer\n");
> +		return -ENXIO;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, dma_addr, len, xfer_dir,
> +					   DMA_PREP_INTERRUPT);
> +	if (!desc) {
> +		dev_err(mtd->dev.parent,
> +			"failed to prepare DMA descriptor\n");
> +		ret = PTR_ERR(desc);
> +		goto err;
> +	}
> +	desc->callback = dma_callback;
> +	desc->callback_param = nand;
> +
> +	nand->dma_cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(nand->dma_cookie);
> +	if (ret) {
> +		dev_err(mtd->dev.parent,
> +			"failed to submit DMA descriptor\n");
> +		goto err;
> +	}
> +
> +	dev_dbg(mtd->dev.parent, "issue DMA with cookie=%d\n",
> +		nand->dma_cookie);
> +	dma_async_issue_pending(chan);
> +
> +	ret = wait_for_completion_timeout(&nand->dma_complete,
> +					  msecs_to_jiffies(LS1X_NAND_TIMEOUT));
> +	if (ret <= 0) {
> +		dev_err(mtd->dev.parent, "DMA timeout\n");
> +		dmaengine_terminate_all(chan);
> +		ret = -EIO;
> +	}
> +	ret = 0;
> +err:
> +	dma_unmap_single(chan->device->dev, dma_addr, len, data_dir);
> +
> +	return ret;
> +}
> +
> +static void ls1x_nand_select_chip(struct mtd_info *mtd, int chip)
> +{
> +}
> +
> +static int ls1x_nand_dev_ready(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand *nand = nand_get_controller_data(chip);
> +
> +	if (nand_readl(nand, NAND_CMD) & OP_DONE)
> +		return 1;

Is the OP_DONE really encoding the status of the R/B line? It seems to
me that it's only about NAND operation status. If that's the case, do
you have a way to only retrieve the R/B status?

> +
> +	return 0;
> +}
> +
> +static uint8_t ls1x_nand_read_byte(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand *nand = nand_get_controller_data(chip);
> +
> +	return *(nand->data_ptr++);
> +}
> +
> +static void ls1x_nand_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand *nand = nand_get_controller_data(chip);
> +
> +	int real_len = min_t(size_t, len, nand->buf_len - nand->buf_off);
> +
> +	memcpy(buf, nand->dma_buf + nand->buf_off, real_len);
> +	nand->buf_off += real_len;
> +}
> +
> +static void ls1x_nand_write_buf(struct mtd_info *mtd, const uint8_t *buf,
> +				int len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand *nand = nand_get_controller_data(chip);
> +
> +	int real_len = min_t(size_t, len, nand->buf_len - nand->buf_off);
> +
> +	memcpy(nand->dma_buf + nand->buf_off, buf, real_len);
> +	nand->buf_off += real_len;
> +}

The same comment applies to {read,write}_{byte,buf}: please avoid
retrieving data from the NAND before those functions are actually
called. I don't know if what I'm asking is doable, but consider
delaying the dma_transfer until you know how many bytes are required.
If you have a PIO mode, you should consider using it instead of doing
DMA transfers.

> +
> +static inline void set_addr_len(struct mtd_info *mtd, unsigned int command,
> +				int column, int page_addr)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand *nand = nand_get_controller_data(chip);
> +	int page_shift, addr_low, addr_high;
> +
> +	if (command == NAND_CMD_ERASE1)
> +		page_shift = chip->page_shift;
> +	else
> +		page_shift = chip->page_shift + 1;
> +
> +	addr_low = page_addr << page_shift;
> +
> +	if (column != -1) {
> +		if (command == NAND_CMD_READOOB)
> +			column += mtd->writesize;
> +		addr_low += column;
> +		nand->buf_off = 0;
> +	}
> +
> +	addr_high =
> +	    page_addr >> (sizeof(page_addr) * BITS_PER_BYTE - page_shift);
> +
> +	if (command == NAND_CMD_ERASE1)
> +		nand->buf_len = 1;
> +	else
> +		nand->buf_len = mtd->writesize + mtd->oobsize - column;
> +
> +	nand_writel(nand, NAND_ADDRL, addr_low);
> +	nand_writel(nand, NAND_ADDRH, addr_high);
> +	nand_writel(nand, NAND_OP_NUM, nand->buf_len);
> +}
> +
> +static void ls1x_nand_cmdfunc(struct mtd_info *mtd, unsigned int command,
> +			      int column, int page_addr)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct ls1x_nand *nand = nand_get_controller_data(chip);
> +
> +	dev_dbg(mtd->dev.parent, "cmd = 0x%02x, col = 0x%08x, page = 0x%08x\n",
> +		command, column, page_addr);
> +
> +	if (command == NAND_CMD_RNDOUT) {
> +		nand->buf_off = column;
> +		return;
> +	}
> +
> +	/*set address, buffer length and buffer offset */
> +	if (column != -1 || page_addr != -1)
> +		set_addr_len(mtd, command, column, page_addr);
> +
> +	/*prepare NAND command */
> +	switch (command) {
> +	case NAND_CMD_RESET:
> +		nand->cmd_val = CMD_RESET;
> +		break;
> +	case NAND_CMD_STATUS:
> +		nand->cmd_val = CMD_STATUS;
> +		break;
> +	case NAND_CMD_READID:
> +		nand->cmd_val = CMD_READID;
> +		break;
> +	case NAND_CMD_READ0:
> +		nand->cmd_val = OP_SPARE | OP_MAIN | CMD_READ;
> +		break;
> +	case NAND_CMD_READOOB:
> +		nand->cmd_val = OP_SPARE | CMD_READ;
> +		break;
> +	case NAND_CMD_ERASE1:
> +		nand->cmd_val = CMD_ERASE;
> +		break;
> +	case NAND_CMD_PAGEPROG:
> +		break;
> +	case NAND_CMD_SEQIN:
> +		if (column < mtd->writesize)
> +			nand->cmd_val = OP_SPARE | OP_MAIN | CMD_WRITE;
> +		else
> +			nand->cmd_val = OP_SPARE | CMD_WRITE;
> +	default:
> +		return;
> +	}
> +
> +	/*set NAND command */
> +	set_cmd(nand, nand->cmd_val);
> +	/*trigger NAND operation */
> +	start_nand(nand);
> +	/*trigger DMA for R/W operation */
> +	if (command == NAND_CMD_READ0 || command == NAND_CMD_READOOB)
> +		start_dma(nand, nand->buf_len, false);
> +	else if (command == NAND_CMD_PAGEPROG)
> +		start_dma(nand, nand->buf_len, true);
> +	nand_wait_ready(mtd);
> +
> +	if (command == NAND_CMD_STATUS) {
> +		nand->datareg[0] = (char)(nand_readl(nand, NAND_STATUS) >> 8);
> +		/*work around hardware bug for invalid STATUS */
> +		nand->datareg[0] |= 0xc0;
> +		nand->data_ptr = nand->datareg;
> +	} else if (command == NAND_CMD_READID) {
> +		nand->datareg[0] = (char)(nand_readl(nand, NAND_IDH));
> +		nand->datareg[1] = (char)(nand_readl(nand, NAND_IDL) >> 24);
> +		nand->datareg[2] = (char)(nand_readl(nand, NAND_IDL) >> 16);
> +		nand->datareg[3] = (char)(nand_readl(nand, NAND_IDL) >> 8);
> +		nand->datareg[4] = (char)(nand_readl(nand, NAND_IDL));
> +		nand->data_ptr = nand->datareg;
> +	}

I hate those controllers trying to automate some basic operations like
RESET, READID or STATUS. Do you have a way to send raw CMD and ADDR
cycles (BTW, do you have a public datasheet for this IP?)?

There's a real reason to avoid those custom ->cmdfunc()
implementations: each time we want to add generic support for a new
NAND command, we have to patch all those custom implementations.

BTW, I see that you don't support the NAND_CMD_PARAM and
NAND_CMD_{SET,GET}_FEATURES commands, which are mandatory if you want
to interface with ONFI NANDs.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
