From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH V3] cpuidle: Add a sysfs entry to disable
 specific C state for debug purpose.
Date: Tue, 13 Mar 2012 17:49:15 -0300
Message-ID: <20120313204915.GD3260@khazad-dum.debian.net>
References: <C6CB66606345BC4B80CBE69D22ABFBB1021C7F@SHSMSX101.ccr.corp.intel.com>
	<1330647453.1916.7.camel@ymzhang>
	<20120302142303.648285a7.akpm@linux-foundation.org>
	<C6CB66606345BC4B80CBE69D22ABFBB10220E1@SHSMSX101.ccr.corp.intel.com>
	<4F545A4E.8010801@linux.vnet.ibm.com> <4F5466C4.2090808@intel.com>
	<20120305101827.GA19408@khazad-dum.debian.net>
	<1330995854.1916.39.camel@ymzhang>
	<20120313004229.GA21111@khazad-dum.debian.net>
	<1331601480.1916.149.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1331601480.1916.149.camel@ymzhang>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, ShuoX Liu <shuox.liu@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, 13 Mar 2012, Yanmin Zhang wrote:
> > > > > +static ssize_t store_state_##_name(struct cpuidle_state *state, \
> > > > > +		const char *buf, size_t size) \
> > > > > +{ \
> > > > > +	int value; \
> > > > > +	sscanf(buf, "%d", &value); \
> > > > > +	if (value) \
> > > > > +		state->disable = 1; \
> > > > > +	else \
> > > > > +		state->disable = 0; \
> > > > > +	return size; \
> > > > > +}
> > > > 
> > > > Isn't this missing a check for capabilities?  Disabling cpuidle states is
> > > > not something random Joe (and IMHO that does mean random capability-
> > > > restricted Joe root) should be doing...
> > > Sorry. Could you elaborate it?
> > 
> > Sure.  Should any user be able to disable a C state, therefore causing
> > the system to consume more power?
> Here we use the simple way to check access. Only root could change it.

Yea, but capabilities are supposed to constrain root as well :-)

> > I am pretty sure the answer is NO, in which case you should check for
> > the appropriate user credentials before you allow a write to these
> > "debug" controls to succeed.  "capability" here is one of the CAP_*
> > capabilities tested through capable(), which are supposed to limit even
> > root.
> We would add below check.
>  
>         if (!capable(CAP_SYS_ADMIN))
>                 return -EPERM;

Looks good.

Thanks!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
