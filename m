From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu
 node in DT.
Date: Fri, 01 Nov 2013 23:52:16 +0100
Message-ID: <1597404.WcAR96MJS1@vostro.rjw.lan>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
 <1436787.LWqDTIBNS8@vostro.rjw.lan> <20131101131452.GJ26890@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131101131452.GJ26890@lunn.ch>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, November 01, 2013 02:14:52 PM Andrew Lunn wrote:
> On Fri, Nov 01, 2013 at 02:16:37PM +0100, Rafael J. Wysocki wrote:
> > On Friday, November 01, 2013 10:07:37 AM Andrew Lunn wrote:
> > > On Fri, Nov 01, 2013 at 05:21:03AM +0530, Viresh Kumar wrote:
> > > > On 1 November 2013 03:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > > On Thursday, October 31, 2013 08:18:31 PM Andrew Lunn wrote:
> > > > >> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
> > > > >> is also an interrupt generated when the DFS hardware completes a
> > > > >> change of frequencey. Add these to the cpu node in DT.
> > > > >>
> > > > >> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > > >> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > > >
> > > > > I need someone with DT bindings knowledge to ACK this for me.
> > > > 
> > > > I can do that
> > > 
> > > Thanks.
> > > 
> > > , but this set has to be rebased over all the latest developments
> > > > in cpufreq core before getting posted again..
> > > 
> > > I will wait for -rc1 and rebase.
> > 
> > Actually, it is possible that 3.12-rc8 will be released this weekend.  If that
> > happens, please rebase your patchset on top of the current linux-next and
> > resubmit it next week.
> 
> Hi Rafael
> 
> Just be to sure, since we have had problems with terminology before.
> Do you mean the The linux-next, or your linux next branch?

That shouldn't matter a lot at this point I think.  Generally, if I'm supposed
to take the patches, it's safer to rebase them against my linux-next branch.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
