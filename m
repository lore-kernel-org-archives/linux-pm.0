From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: In Embedded system the dev_pm_info.power_state is
 useful
Date: Fri, 23 May 2008 14:19:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805231415310.3106-100000@iolanthe.rowland.org>
References: <4836D570.2020905@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4836D570.2020905@st.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Francesco VIRLINZI <francesco.virlinzi@st.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 23 May 2008, Francesco VIRLINZI wrote:

> Hi Alan
> Thank for your reply.
> > That isn't the only way to check the power state.  You should have a 
> > private data structure associated with each of the devices you care 
> > about.  The address of the private data structure is what you store in 
> > platform_set_drvdata().  In the private data structure you can have a 
> > field to indicate the device's power state.
> >   
> Yes you are right.
> The problem is that each driver can use the private_data as it wants, 
> while I need a generic
>  API to understand the power state of device.

That's not the only problem.  Each driver can also use 
dev->power.power_state.event the way it wants.  So looking at that 
field won't tell you anything.

> Your suggestion works fine if (internally) we assume an agreement
>  (i.e.: the first word in the private data is the power state) and in 
> this manner
>  I can analyse several IP with a single API.
> But to do that (at the moment) I just do
>     (dev->power.power_state.event == xx)
> 
> and PM_EVENT_ON/PM_EVENT_SUSPEND are good enough.
> 
> Why did you decide to remove it?

Because it is almost meaningless.  For example, suppose a particular
platform device has 3 power states: On with high performance, on with
low performance, and off.  Then how can you tell which state it is in
by looking at dev->power.power_state.event?

I suspect that you are trying to solve some problem in the wrong way.  
But without knowing what that problem is, I can't advise you on better
ways to solve it.

Alan Stern
