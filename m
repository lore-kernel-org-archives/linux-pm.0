From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Tue, 18 Mar 2008 22:33:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803182228520.10154-100000__28713.0593009808$1205894194$gmane$org@netrider.rowland.org>
References: <200803190108.05004.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803190108.05004.rjw@sisk.pl>
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
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Mar 2008, Rafael J. Wysocki wrote:

> Well, I've been saying that for I-don't-remember-how-long: on my box, if you
> use S5 instead of entering S4, the fan doesn't work correctly after the
> resume.  Plain and simple.
> 
> Perhaps there's a problem with our ACPI drivers that causes this to happen,
> but I have no idea what that can be at the moment.

IMO it would be worthwhile to track this down.  It's a clear indication 
that something is wrong somewhere.

Could it be connected with the way the boot kernel hands control over
to the image kernel?  Presumably ACPI isn't prepared to deal with that
sort of thing during a boot from S5.  It would have to be fooled into
thinking the two kernels were one and the same.

Alan Stern
