From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: In Embedded system the dev_pm_info.power_state is
 useful
Date: Fri, 23 May 2008 16:32:16 +0200
Message-ID: <4836D570.2020905@st.com>
References: <Pine.LNX.4.44L0.0805231002160.2103-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0805231002160.2103-100000@iolanthe.rowland.org>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Alan
Thank for your reply.
> That isn't the only way to check the power state.  You should have a 
> private data structure associated with each of the devices you care 
> about.  The address of the private data structure is what you store in 
> platform_set_drvdata().  In the private data structure you can have a 
> field to indicate the device's power state.
>   
Yes you are right.
The problem is that each driver can use the private_data as it wants, 
while I need a generic
 API to understand the power state of device.
Your suggestion works fine if (internally) we assume an agreement
 (i.e.: the first word in the private data is the power state) and in 
this manner
 I can analyse several IP with a single API.
But to do that (at the moment) I just do
    (dev->power.power_state.event == xx)

and PM_EVENT_ON/PM_EVENT_SUSPEND are good enough.

Why did you decide to remove it?

Regards
 Francesco


> If the platform-bus IP really is generic then you can't possibly know
> what its dev_pm_info.power_state value means, anyway.
>
> Alan Stern
>
>   
