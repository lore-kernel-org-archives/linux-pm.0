From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Query: When will drv->poweroff() called
Date: Mon, 6 Feb 2012 13:07:40 +0100
Message-ID: <201202061307.40628.rjw@sisk.pl>
References: <4F2F6B40.6070308@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4F2F6B40.6070308@st.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Viresh Kumar <viresh.kumar@st.com>
Cc: len.brown@intel.com, Vipul Kumar SAMAR <vipulkumar.samar@st.com>, Bhupesh SHARMA <bhupesh.sharma@st.com>, Pratyush ANAND <pratyush.anand@st.com>, Armando VISCONTI <armando.visconti@st.com>, Mirko GARDI <mirko.gardi@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Amit VIRDI <amit.virdi@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, deepak sikri <deepak.sikri@st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Vincenzo FRASCINO <Vincenzo.FRASCINO@st.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, February 06, 2012, Viresh Kumar wrote:
> 
> Hi Guys,
> 
> Sorry for asking this silly question, but i couldn't locate much
> help for it in documentation, so asking it.
> 
> We were testing hibernation for SPEAr13xx SoC family, based on
> ARM Cortex a9.
> 
> I observed that poweroff() callback of individual drivers are not
> getting called at all, while we test hibernate.

They should be called in the last phase of hibernation, after the image
has been created and the system is going for "power off" (hance the
callback name).

> I tried to go through the code to see what happened. It looked like
> there should be call to hibernation_set_ops() for platforms that are
> willing to get a call to poweroff() for their drivers.

That's correct.  The ->poweroff() callbacks are only executed if
hibernation_mode is equal to HIBERNATION_PLATFORM, which is not the
default.

> Otherwise shutdown of the busses gets called, which is a completely
> different path.
> 
> There are many drivers today, that are registering poweroff() from dev_pm_ops
> but are not doing bus specific shutdown stuff.
> 
> Even i tried to look for hibernation_set_ops() in kernel, and only acpi
> code is calling it.

That's correct too.

> I didn't understood how other ARM Sub-Arch's are handling this.

Well, they are supposed to call hibernation_set_ops() and set the operations
appropriately.  Those operations may be empty routines if they don't need
to do anything, but they have to be defined.

Thanks,
Rafael
