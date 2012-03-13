From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH V3] cpuidle: Add a sysfs entry to disable
 specific C state for debug purpose.
Date: Mon, 12 Mar 2012 21:42:29 -0300
Message-ID: <20120313004229.GA21111@khazad-dum.debian.net>
References: <C6CB66606345BC4B80CBE69D22ABFBB1021C7F@SHSMSX101.ccr.corp.intel.com>
	<1330647453.1916.7.camel@ymzhang>
	<20120302142303.648285a7.akpm@linux-foundation.org>
	<C6CB66606345BC4B80CBE69D22ABFBB10220E1@SHSMSX101.ccr.corp.intel.com>
	<4F545A4E.8010801@linux.vnet.ibm.com> <4F5466C4.2090808@intel.com>
	<20120305101827.GA19408@khazad-dum.debian.net>
	<1330995854.1916.39.camel@ymzhang>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1330995854.1916.39.camel@ymzhang>
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

On Tue, 06 Mar 2012, Yanmin Zhang wrote:
> On Mon, 2012-03-05 at 07:18 -0300, Henrique de Moraes Holschuh wrote:
> > On Mon, 05 Mar 2012, ShuoX Liu wrote:
> > > @@ -45,6 +46,7 @@ total 0
> > >  /sys/devices/system/cpu/cpu0/cpuidle/state1:
> > >  total 0
> > >  -r--r--r-- 1 root root 4096 Feb  8 10:42 desc
> > > +-rw-r--r-- 1 root root 4096 Feb  8 10:42 disable
> > >  -r--r--r-- 1 root root 4096 Feb  8 10:42 latency
> > >  -r--r--r-- 1 root root 4096 Feb  8 10:42 name
> > >  -r--r--r-- 1 root root 4096 Feb  8 10:42 power
> > 
> > ...
> > 
> > > diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> > > index 3fe41fe..1eae29a 100644
> > > --- a/drivers/cpuidle/sysfs.c
> > > +++ b/drivers/cpuidle/sysfs.c
> > > @@ -222,6 +222,9 @@ struct cpuidle_state_attr {
> > >  #define define_one_state_ro(_name, show) \
> > >  static struct cpuidle_state_attr attr_##_name = __ATTR(_name, 0444,
> > > show, NULL)
> > > 
> > > +#define define_one_state_rw(_name, show, store) \
> > > +static struct cpuidle_state_attr attr_##_name = __ATTR(_name, 0644,
> > > show, store)
> > > +
> > >  #define define_show_state_function(_name) \
> > >  static ssize_t show_state_##_name(struct cpuidle_state *state, \
> > >  			 struct cpuidle_state_usage *state_usage, char *buf) \
> > > @@ -229,6 +232,19 @@ static ssize_t show_state_##_name(struct
> > > cpuidle_state *state, \
> > >  	return sprintf(buf, "%u\n", state->_name);\
> > >  }
> > > 
> > > +#define define_store_state_function(_name) \
> > > +static ssize_t store_state_##_name(struct cpuidle_state *state, \
> > > +		const char *buf, size_t size) \
> > > +{ \
> > > +	int value; \
> > > +	sscanf(buf, "%d", &value); \
> > > +	if (value) \
> > > +		state->disable = 1; \
> > > +	else \
> > > +		state->disable = 0; \
> > > +	return size; \
> > > +}
> > 
> > Isn't this missing a check for capabilities?  Disabling cpuidle states is
> > not something random Joe (and IMHO that does mean random capability-
> > restricted Joe root) should be doing...
> Sorry. Could you elaborate it?

Sure.  Should any user be able to disable a C state, therefore causing
the system to consume more power?

I am pretty sure the answer is NO, in which case you should check for
the appropriate user credentials before you allow a write to these
"debug" controls to succeed.  "capability" here is one of the CAP_*
capabilities tested through capable(), which are supposed to limit even
root.

> > Also, maybe it would be best to use one of the lib helpers to parse that
> > value, so that it will be less annoying to userspace (trim blanks, complain
> > if there is trailing junk after trimming, etc)?
> We would use strict_strtol to parse the value in next version.

Thanks!

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
