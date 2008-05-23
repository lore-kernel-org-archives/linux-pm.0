From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: In Embedded system the dev_pm_info.power_state is
 useful
Date: Fri, 23 May 2008 10:07:26 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805231002160.2103-100000@iolanthe.rowland.org>
References: <48365CA3.4070808@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48365CA3.4070808@st.com>
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

> Hi all
> I'm Francesco Virlinzi and I work in STMicroelectronics, I'm a 
> developers of STLinux (www.stlinux.com) an
>   embedded Linux distribution for ST Set Top Box.
> 
> I read in the pm mail list that you are going to remove in the kernel the
>  dev_pm_info.power_state field in the dev_pm_info struct replaced by 
> bus-specific field.
> 
> My request is: don't do that.
> In embedded system it' s really useful because there are a lot of 
> generic IP on a single bus (the pltaform bus)
>   and the only way to check the power state of each IP is based on  
> 'dev_pm_info.power_state'
>   without this filed we will have our IP (platform_device) with no power 
> state concept...

That isn't the only way to check the power state.  You should have a 
private data structure associated with each of the devices you care 
about.  The address of the private data structure is what you store in 
platform_set_drvdata().  In the private data structure you can have a 
field to indicate the device's power state.

If the platform-bus IP really is generic then you can't possibly know
what its dev_pm_info.power_state value means, anyway.

Alan Stern
