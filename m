From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 7/8] ACPI: acpi_idle: touch TS_POLLING only
 in the non-MWAIT case
Date: Fri, 28 May 2010 13:59:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005281351380.4045__3854.67755045301$1275069711$gmane$org@localhost.localdomain>
References: <6b2c676bf32be91f43215d5874c07c1becaba013.1275026041.git.len.brown@intel.com>
	<1275026521-30835-1-git-send-email-lenb@kernel.org>
	<c4716a7a5639fd8f82dc6f2046b127e65a3851c5.1275026041.git.len.brown@intel.com>
	<AANLkTikRUyXMcIkqc3dRCtLPkKBOwOeyy_j1iILHeypj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <AANLkTikRUyXMcIkqc3dRCtLPkKBOwOeyy_j1iILHeypj@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Venkatesh Pallipadi <venki@google.com>
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 28 May 2010, Venkatesh Pallipadi wrote:

> On Thu, May 27, 2010 at 11:02 PM, Len Brown <lenb@kernel.org> wrote:
> > From: Len Brown <len.brown@intel.com>
> >
> > commit d306ebc28649b89877a22158fe0076f06cc46f60
> > (ACPI: Be in TS_POLLING state during mwait based C-state entry)
> > fixed an important power & performance issue where ACPI c2 and c3 C-states
> > were clearing TS_POLLING even when using MWAIT (ACPI_STATE_FFH).
> > That bug had been causing us to receive redundant scheduling interrups
> > when we had already been woken up by MONITOR/MWAIT.
> >
> > Following up on that...
> >
> > In the MWAIT case, we don't have to subsequently
> > check need_resched(), as that c heck was there
> > for the TS_POLLING-clearing case.
> >
> > Note that not only does the cpuidle calling function
> > already check need_resched() before calling us, the
> > low-level entry into monitor/mwait calls it twice --
> > guaranteeing that a write to the trigger address
> > can not go un-noticed.
> 
> Ack this part of the change.
> 
> > Also, in this case, we don't have to set TS_POLLING
> > when we wake, because we never cleared it.
> 
> I thought about this part of the change while working on the original
> patch. But decided to leave the set to be done unconditionally as in
> this case we are replacing "one write" by either "one read and one
> jump" or "one read and one write" and I am not sure we gain much by
> that.

I don't know if the write is more expensive than the read and branch.
In the scheme of things, these things are free and it is the IO
accesses and locks in the idle path that take time.

But when I saw this code fragment incorrectly copied into
the new sfi_idle driver, I decided it was time to change it
to make logical sense to the reader.

thanks,
-Len Brown, Intel Open Source Technology Center
