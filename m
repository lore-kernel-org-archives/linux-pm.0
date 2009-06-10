From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [patch update] Re: Run-time PM idea (was: Re:
	[RFC][PATCH 0/2] PM: Rearrange core suspend code)
Date: Wed, 10 Jun 2009 16:20:26 +0200
Message-ID: <200906101620.26559.oliver__21305.3486230367$1244643639$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0906082233490.19072-100000@netrider.rowland.org>
	<200906100057.04473.rjw@sisk.pl> <200906101029.27529.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200906101029.27529.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Am Mittwoch, 10. Juni 2009 10:29:26 schrieb Rafael J. Wysocki:
> Argh, I forgot about some important things.
>
> First, there are devices with no parent (actually, it would be much easier
> if they had a default dummy parent, but that's a separate issue).
>
> Second, the parent has to be taken into account in the asynchronous resume
> path too (which BTW is more complicated).

What happens if the parent's parent is also suspended? It seems to me that
you must code this recursively.

	Regards
		Oliver
