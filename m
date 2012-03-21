From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] thermal: Fix for setting the thermal zone
 mode to enable/disable
Date: Wed, 21 Mar 2012 16:27:57 +0100
Message-ID: <20120321162757.527f87e2@endymion.delvare>
References: <1332328201-21191-1-git-send-email-amit.kachhap@linaro.org>
	<20120321151357.53fb86e4@endymion.delvare>
	<CAMuHMdUFh=kRJFGP3sxHCqERSVcrWGD40iYzhrFMRxDNFvounA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMuHMdUFh=kRJFGP3sxHCqERSVcrWGD40iYzhrFMRxDNFvounA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linaro-dev@lists.linaro.org, patches@linaro.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, 21 Mar 2012 16:14:46 +0100, Geert Uytterhoeven wrote:
> On Wed, Mar 21, 2012 at 15:13, Jean Delvare <khali@linux-fr.org> wrote:
> > On Wed, 21 Mar 2012 16:40:01 +0530, Amit Daniel Kachhap wrote:
> >> Basically without this patch changing the mode of thermal zone
> >> is not possible as wrong string size is passed to strncmp.
> >
> > Actually it is possible,
> > $ echo -n disabled > mode
> > works fine. But it fails without the -n, your patch would fix that.
> 
> Now it ignores any extra characters. Are they always newlines?
> 
> Now "echo -n disabledx > mode" will also "succeed".

I guess this is considered good enough in practice, although I also
don't like this use of strncmp. I'd prefer \n to be properly converted
to \0 (by the sysfs layer itself) so that strict string comparisons can
be done. I don't have the time to push this though, sorry.

-- 
Jean Delvare
