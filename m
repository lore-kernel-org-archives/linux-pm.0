From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC] Linux Power Management
Date: Tue, 3 May 2005 23:40:09 +0200
Message-ID: <20050503214009.GE10404@elf.ucw.cz>
References: <1115094736.28902.167.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============11442818831319612=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1115094736.28902.167.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============11442818831319612==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> Device Drivers
> ==============
> 
> Linux device drivers must often save and restore state during power
> transitions.  The following API is proposed:
> 
> ->prepare_state(struct device * dev, pm_state_t state,
>                 unsigned int reason);
> ->complete_state(struct device * dev, pm_state_t state,
>                 unsigned int reason);
> 
> The following would be an example of a typical transition:
> 
> 1.) the policy manager decides to put a PCI ethernet card into D3 from
> D0.
> 2.) ->prepare_state is called, the ethernet driver saves its state
> information and disables the hardware
> 3.) the power driver's ->set_state function is called, and power is
> actually removed.
> 4.) ->complete_state is called to cleanup and make any final
> adjustments.
> 
> * In the case of D3->D0 ->complete_state would restore state.
> 
> Possible "reasons" might include DYNAMIC_PM, HALT, REBOOT, SUSPEND,
> RESUME, etc.
> 
> This API is different from the current ->suspend and ->resume because it
> applies to situations outside of system suspend (e.g. runtime power
> management) and has an emphasis on specific device power states. 

No. It took 2+ years to add at at least system power states. You want
to build on that, not scratch it and start over.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============11442818831319612==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============11442818831319612==--
