From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/1] platform/x86/dell-laptop: Add another
	Dell laptop	to the DMI whitelist
Date: Sun, 14 Feb 2010 16:57:35 +0000
Message-ID: <20100214165735.GB25624__23723.8467125737$1266166709$gmane$org@srcf.ucam.org>
References: <1266144897-2681-1-git-send-email-erik.andren@gmail.com>
	<20100214154709.GA7271@rhlx01.hs-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100214154709.GA7271@rhlx01.hs-esslingen.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andreas Mohr <andi@lisas.de>
Cc: linux-pm@lists.linux-foundation.org, Erik Andren <erik.andren@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 14, 2010 at 04:47:10PM +0100, Andreas Mohr wrote:
> Definitely not only this one. E.g. my Inspiron 8000 (P3/700) has (dmidecode):
> 
> Handle 0x0300, DMI type 3, 13 bytes
> Chassis Information
>         Manufacturer: Dell Computer Corporation
>         Type: Portable
> 
> which, if "Portable" happens to be "8", means that it would match.

8 should be portable, yes. 9 would be laptop (and 10 notebook), but I 
haven't seen any examples of those in Dells.

> So:
> - do all older matching machines grok this?

The dcdbas call should fail if they don't, so I think we're ok.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
