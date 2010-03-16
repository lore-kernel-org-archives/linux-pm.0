From: Joe Perches <joe@perches.com>
Subject: Re: [RESEND][PATCH] intel_txt: add support for S3 memory
 integrity protection within Intel(R) TXT launched kernel (v3)
Date: Mon, 15 Mar 2010 23:38:18 -0700
Message-ID: <1268721498.16849.5.camel__37767.1924107291$1268721652$gmane$org@Joe-Laptop.home>
References: <1268749871-2521-1-git-send-email-shane.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1268749871-2521-1-git-send-email-shane.wang@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shane Wang <shane.wang@intel.com>
Cc: joseph.cihula@intel.com, linux-kernel@vger.kernel.org, hpa@zytor.com, linux-pm@lists.linux-foundation.org, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

> diff -r d2911aa1461d MAINTAINERS
> --- a/MAINTAINERS	Thu Mar 04 09:37:53 2010 -0500
> +++ b/MAINTAINERS	Wed Mar 10 08:18:48 2010 -0500
> @@ -2891,6 +2891,17 @@ F:	Documentation/networking/README.ipw22
>  F:	Documentation/networking/README.ipw2200
>  F:	drivers/net/wireless/ipw2x00/ipw2200.*
>  
> +INTEL(R) TRUSTED EXECUTION TECHNOLOGY (TXT)
> +M:	Joseph Cihula <joseph.cihula@intel.com>
> +M:	Shane Wang <shane.wang@intel.com>
> +L:	tboot-devel@lists.sourceforge.net
> +W:	http://tboot.sourceforge.net
> +T:	Mercurial http://www.bughost.org/repos.hg/tboot.hg

The introductory documentation in MAINTAINERS has:
	T: SCM tree type and location.  Type is one of: git, hg, quilt, stgit.
So perhaps that's should be:
T:	hg http://www.bughost.org/repos.hg/tboot.hg
