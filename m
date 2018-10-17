From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/8] cpufreq: tegra186: don't pass
 GFP_DMA32 to dma_alloc_coherent
Date: Wed, 17 Oct 2018 09:19:42 +0200
Message-ID: <20181017071942.GB23407@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-2-hch@lst.de>
 <CAJZ5v0ju2Y=yQn9uz6HpYGw5BZovxYh2YbYD7Ujq8kajJfvLSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ju2Y=yQn9uz6HpYGw5BZovxYh2YbYD7Ujq8kajJfvLSQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, dri-devel <dri-devel@lists.freedesktop.org>, linux-spi <linux-spi@vger.kernel.org>, linux-tegra@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 15, 2018 at 09:43:04AM +0200, Rafael J. Wysocki wrote:
> On Sat, Oct 13, 2018 at 5:17 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The DMA API does its own zone decisions based on the coherent_dma_mask.
> >
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Can you pick it up through the cpufreq tree?
