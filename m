From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Wed, 19 Mar 2008 11:01:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803191057270.4958-100000__26504.6301916756$1205939211$gmane$org@netrider.rowland.org>
References: <m1ve3jtmxk.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m1ve3jtmxk.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Mar 2008, Eric W. Biederman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:

> > Could it be connected with the way the boot kernel hands control over
> > to the image kernel?  Presumably ACPI isn't prepared to deal with that
> > sort of thing during a boot from S5.  It would have to be fooled into
> > thinking the two kernels were one and the same.
> 
> It should be easy to test if it is a hand over problem, by turning off
> the laptop by placing it in S5 (shutdown -h now) and then booting same
> kernel again.

?  Doesn't this happen every time Rafael turns the computer off and 
then turns it back on?

Do you mean that Rafael should do an S5-type hibernate, but then reboot 
in such a way that the image isn't loaded and resumed?

Alan Stern
