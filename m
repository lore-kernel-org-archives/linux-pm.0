From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [PATCH] ACPI suspend: Blacklist boxes that require
 us to set SCI_EN directly on resume
Date: Mon, 17 Nov 2008 23:45:59 -0600
Message-ID: <49225697.90804__43764.3143967309$1226987322$gmane$org@shaw.ca>
References: <200811172333.13466.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200811172333.13466.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Tino Keitel <tino.keitel@gmx.de>, Bob Copeland <me@bobcopeland.com>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: ACPI suspend: Blacklist boxes that require us to set SCI_EN directly on resume
> 
> Some Apple boxes evidently require us to set SCI_EN on resume
> directly, because if we don't do that, they hung somewhere in the
> resume code path.  Moreover, on these boxes it is not sufficient to
> use acpi_enable() to turn ACPI on during resume.  All of this is
> against the ACPI specification which states that (1) the BIOS is
> supposed to return from the S3 sleep state with ACPI enabled
> (SCI_EN set) and (2) the SCI_EN bit is owned by the hardware and we
> are not supposed to change it.
> 
> For this reason, blacklist the affected systems so that the SCI_EN
> bit is set during resume on them.
> 
> [NOTE: Unconditional setting SCI_EN for all system on resume doesn't
>  work, because it makes some other systems crash (that's to be
>  expected).  Also, it is not entirely clear right now if all of the
>  Apple boxes require this workaround.]

This is rather gross. The usual question arises, why does Windows work 
without such a hack? Maybe there is no better solution for now, but 
somebody should really look into why the behavior is different in Linux..
