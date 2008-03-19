From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Tue, 18 Mar 2008 21:25:27 -0600
Message-ID: <m1ve3jtmxk.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.44L0.0803182228520.10154-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0803182228520.10154-100000@netrider.rowland.org>
	(Alan Stern's message of "Tue, 18 Mar 2008 22:33:31 -0400 (EDT)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Wed, 19 Mar 2008, Rafael J. Wysocki wrote:
>
>> Well, I've been saying that for I-don't-remember-how-long: on my box, if you
>> use S5 instead of entering S4, the fan doesn't work correctly after the
>> resume.  Plain and simple.
>> 
>> Perhaps there's a problem with our ACPI drivers that causes this to happen,
>> but I have no idea what that can be at the moment.
>
> IMO it would be worthwhile to track this down.  It's a clear indication 
> that something is wrong somewhere.
>
> Could it be connected with the way the boot kernel hands control over
> to the image kernel?  Presumably ACPI isn't prepared to deal with that
> sort of thing during a boot from S5.  It would have to be fooled into
> thinking the two kernels were one and the same.

It should be easy to test if it is a hand over problem, by turning off
the laptop by placing it in S5 (shutdown -h now) and then booting same
kernel again.

Eric
