From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v2 0/8] Add Simple Power-Managed Bus Support
Date: Fri, 09 Jan 2015 00:51:23 +0200
Message-ID: <10372546.9gL7hIlFWP@avalon>
References: <1418842153-17113-1-git-send-email-geert+renesas@glider.be> <CAMuHMdVeEmKiqGTOmevaBDbJ=nBTbSi6d6Xrm0eyvbMTtyU=sA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVeEmKiqGTOmevaBDbJ=nBTbSi6d6Xrm0eyvbMTtyU=sA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulrich Hecht <ulrich.hecht+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Thursday 08 January 2015 20:28:45 Geert Uytterhoeven wrote:
> On Wed, Dec 17, 2014 at 7:49 PM, Geert Uytterhoeven wrote:
> > The Renesas Bus State Controller (BSC) provides an external bus for
> > connecting multiple external devices to an SoC, driving several chip
> > select lines, for e.g. NOR FLASH, Ethernet and USB.
> > On the kzm9g and ape6evm development boards, an smsc9220 Ethernet
> > controller is connnected to the BSC of an SH-Mobile AG5 (sh73a0) resp.
> > R-Mobile APE6 (r8a73a4) SoC.
> 
> [...]
> 
> > This was tested on sh73a0/kzm9g-multiplatform. Without this, Ethernet
> > doesn't work, as the ZB clock is disabled by clk_disable_unused().
> > Testing on r8a73a4/ape6evm-multiplatform would be appreciated.
> 
> Has anyone tried this on r8a73a4/ape6evm-multiplatform?

I'm afraid I can't help there, as I have no APE6EVM board.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
