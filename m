From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [RFC] OMAP1 PM Core,  Platform Power Parameter 1/2
Date: Sat, 30 Sep 2006 22:52:58 +0200
Message-ID: <20060930205258.GB3061@elf.ucw.cz>
References: <20060930022428.e27d4c53.eugeny.mints@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751964AbWI3UxK@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060930022428.e27d4c53.eugeny.mints@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org, ext-Tuukka.Tikkanen@nokia.com
List-Id: linux-pm@vger.kernel.org

Hi!

> Basic building block for PM Core layer is platform power parameter concept. A platform power parameter is a name, get and set methods.  
> 
> Although an PM Core implementation is completely arch specific any PM Core is
> supposed to utilize platform power parameter concept.
> 
> Also any PM Core is supposed to export names of all platform power parameters
> available on a platform. Any entity which registeres operating points is primary
> consumer of platform_pwr_param_get_names() interface.
> 
> (Probably this interface routine might be moved to be a part of PowerOP Core 
> interface)
> 
> diff --git a/include/linux/plat_pwr_param.h b/include/linux/plat_pwr_param.h
> new file mode 100644
> index 0000000..3a78d2b
> --- /dev/null
> +++ b/include/linux/plat_pwr_param.h

This is generic code (and please select some more reasonable
filename). It should not be in patch marked "OMAP1".

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
