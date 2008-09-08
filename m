From: "Dasgupta, Romit" <romit@ti.com>
Subject: Re: Info on EHCI/OHCI vs PM
Date: Mon, 8 Sep 2008 12:55:03 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB59301A039B098@dbde02.ent.ti.com>
References: <48C4C3C5.4000503@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <48C4C3C5.4000503@st.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Francesco VIRLINZI <francesco.virlinzi@st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

You need to define the appropriate functions for 
platform_driver.suspend
platform_driver.resume

and 
hc_driver.bus_suspend
hc_driver.bus_resume routines

You may look at
drivers/usb/host/ohci-at91.c (Not sure if that is working though).

Thanks,
-Romit



>-----Original Message-----
>From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-
>bounces@lists.linux-foundation.org] On Behalf Of Francesco VIRLINZI
>Sent: Monday, September 08, 2008 11:49 AM
>To: linux-pm@lists.linux-foundation.org
>Subject: [linux-pm] Info on EHCI/OHCI vs PM
>
>Hi all.
>I need an help on USB vs PM.
>I'm working on a embedded platform with USB Host Controller.
>There is an EHCI with a Companion OHCI and both work fine.
>Now I would add the PM support.
>Until now both the host controller are on the 'platform_bus' therefore
>they seem
> independent.
>
>Is this configuration ok or I have to declare a kind of relationship
> between the host controller (and if so which one)?
>
>Regards
> Francesco
>_______________________________________________
>linux-pm mailing list
>linux-pm@lists.linux-foundation.org
>https://lists.linux-foundation.org/mailman/listinfo/linux-pm
