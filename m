From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: In Embedded system the dev_pm_info.power_state is
 useful
Date: Fri, 23 May 2008 08:17:42 +0200
Message-ID: <48366186.7000303@st.com>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi all
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
>
> At least we could put it under CONFIG_EMBEDDED.
>
> >>What do you THINK ? 
>   

> Regards
>  Francesco
>   
