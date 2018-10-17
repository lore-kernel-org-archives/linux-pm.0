From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 6/8] drm: sti: don't pass GFP_DMA32 to
	dma_alloc_wc
Date: Wed, 17 Oct 2018 09:19:58 +0200
Message-ID: <20181017071958.GC23407@lst.de>
References: <20181013151707.32210-1-hch@lst.de>
 <20181013151707.32210-7-hch@lst.de>
 <CA+M3ks66FL-F8dk+UcG-gR8Gz4N6gz7eYuT_Ht_scw7foPaP0A@mail.gmail.com>
 <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CA+M3ks6a-D4j425JGBof+ma3NX5Fo52k5fadRNRauexOBXuaaw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-pm@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org, ML dri-devel <dri-devel@lists.freedesktop.org>, linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-media@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 16, 2018 at 02:41:23PM +0200, Benjamin Gaignard wrote:
> Le lun. 15 oct. 2018 =E0 11:12, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> a =E9crit :
> >
> > Le sam. 13 oct. 2018 =E0 17:17, Christoph Hellwig <hch@lst.de> a =E9cri=
t :
> > >
> > > The DMA API does its own zone decisions based on the coherent_dma_mas=
k.
> > >
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> >
> > Reviewed-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> =

> Christoph do you plan to merge this patch on your own tree ? or would
> like I put it directly in drm-misc-next branch ?

Please pull it in through drm-misc-next, thanks!
