From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM: OPP: introduce function to free cpufreq
	table
Date: Tue, 24 May 2011 20:49:12 +0200
Message-ID: <201105242049.13044.rjw__33279.6384268024$1306264476$gmane$org@sisk.pl>
References: <1306192335-19883-1-git-send-email-nm@ti.com>
	<20110524000549.GA20225@google.com>
	<BANLkTi=mo_o=WCHg27XeOTYP9gDEFROMVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=mo_o=WCHg27XeOTYP9gDEFROMVQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Menon, Nishanth" <nm@ti.com>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, linux-omap <linux-omap@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 24, 2011, Menon, Nishanth wrote:
> On Mon, May 23, 2011 at 19:05, Todd Poynor <toddpoynor@google.com> wrote:
> > On Mon, May 23, 2011 at 06:12:15PM -0500, Nishanth Menon wrote:
> >> cpufreq table allocated by opp_init_cpufreq_table is better
> >> freed by OPP layer itself. This allows future modifications to
> >> the table handling to be transparent to the users.
> > ...
> >> +void opp_free_cpufreq_table(struct device *dev,
> >> +                             struct cpufreq_frequency_table **table)
> >> +{
> >> +     if (!table)
> >> +             return;
> >> +
> >> +     /* Pretend as if I am an updater */
> >> +     mutex_lock(&dev_opp_list_lock);
> >> +     kfree(*table);
> >> +     *table = NULL;
> >> +     mutex_unlock(&dev_opp_list_lock);
> >> +}
> >
> > Not clear what the mutex protects here.  Currently it protects only
> > device opp list modifications.  opp_init_cpufreq_table holds the lock only
> > while looking up and walking the device opp list; the cpufreq table it
> > creates is not complete by the time the lock is dropped.
> 
> hmm.. right.. mutex protection does'nt really make sense here..

Care to post an updated patch?

Rafael
