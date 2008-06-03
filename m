From: Johannes Weiner <hannes@saeurebad.de>
Subject: Re: [PATCH] add a printk_init variant storing format
	strings in __initdata
Date: Tue, 03 Jun 2008 18:41:31 +0200
Message-ID: <87r6beh3no.fsf__7791.14104011587$1212512681$gmane$org@saeurebad.de>
References: <20080529162257.03426e48.akpm@linux-foundation.org>
	<1212485252.0@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1212485252.0@pinky> (Andy Whitcroft's message of "Tue, 3 Jun
	2008 10:27:32 +0100")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu
List-Id: linux-pm@vger.kernel.org

Hi,

Andy Whitcroft <apw@shadowen.org> writes:

> [As gcc seems unable to help us out selecting the appropriate data segment
> for the code, how about we did something like this?]
>
> When using printk from __init functions it would be desirable to place
> the printk format strings in __initdata.  Add a printk_init() variant
> which does this.

http://lkml.org/lkml/2008/2/4/185

I don't know if `desirable' is the technical argument Sam wants to hear :)

	Hannes
