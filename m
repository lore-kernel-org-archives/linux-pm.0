From: Vasiliy Kulikov <segoon@openwall.com>
Subject: Re: [PATCH] power: disable hibernation if module loading
 is disabled
Date: Sat, 5 Mar 2011 00:52:20 +0300
Message-ID: <20110304215218.GB30253__18072.3520032645$1299275722$gmane$org@albatros>
References: <1299255084-4390-1-git-send-email-segoon@openwall.com>
	<20110304203201.GA22079@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110304203201.GA22079@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, security@kernel.org, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 04, 2011 at 21:32 +0100, Pavel Machek wrote:
> > +	if (modules_disabled)
> > +		return -EPERM;
> > +
> >  	error = platform_begin(platform_mode);
> 
> Hmm. How is this supposed to work with CONFIG_MODULES off?

Good catch, thank you.  I'll fix this.

-- 
Vasiliy Kulikov
http://www.openwall.com - bringing security into open computing environments
