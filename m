From: Andreas Mohr <andi@lisas.de>
Subject: Re: [PATCH 1/1] platform/x86/dell-laptop: Add another
	Dell laptop	to the DMI whitelist
Date: Sun, 14 Feb 2010 16:47:10 +0100
Message-ID: <20100214154709.GA7271__17002.3890831091$1266162594$gmane$org@rhlx01.hs-esslingen.de>
References: <1266144897-2681-1-git-send-email-erik.andren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1266144897-2681-1-git-send-email-erik.andren@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Erik Andren <erik.andren@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mjg@redhat.com
List-Id: linux-pm@vger.kernel.org

> The Latitude C640 has another variation of dell in its DMI vendor entry.
> Add it to the whitelist in order to enjoy the sweet fruits of software
> backlight toggling.

Definitely not only this one. E.g. my Inspiron 8000 (P3/700) has (dmidecode):

Handle 0x0300, DMI type 3, 13 bytes
Chassis Information
        Manufacturer: Dell Computer Corporation
        Type: Portable

which, if "Portable" happens to be "8", means that it would match.

So:
- do all older matching machines grok this?
- if not, do something about it? ;)

[I should probably just offer myself to be a guinea pig]

Thanks for a very interesting piece of work!

Andreas Mohr
