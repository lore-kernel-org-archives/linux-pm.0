From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: Re: [RFC] Linux Power Management
Date: Thu, 5 May 2005 00:12:14 -0400
Message-ID: <20050505041214.GA21223@neo.rr.com>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<20050503214009.GE10404@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============62954231996558629=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050503214009.GE10404@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============62954231996558629==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2005 at 11:40:09PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Device Drivers
> > ==============
> > 
> > Linux device drivers must often save and restore state during power
> > transitions.  The following API is proposed:
> > 
> > ->prepare_state(struct device * dev, pm_state_t state,
> >                 unsigned int reason);
> > ->complete_state(struct device * dev, pm_state_t state,
> >                 unsigned int reason);
> > 
> > The following would be an example of a typical transition:
> > 
> > 1.) the policy manager decides to put a PCI ethernet card into D3 from
> > D0.
> > 2.) ->prepare_state is called, the ethernet driver saves its state
> > information and disables the hardware
> > 3.) the power driver's ->set_state function is called, and power is
> > actually removed.
> > 4.) ->complete_state is called to cleanup and make any final
> > adjustments.
> > 
> > * In the case of D3->D0 ->complete_state would restore state.
> > 
> > Possible "reasons" might include DYNAMIC_PM, HALT, REBOOT, SUSPEND,
> > RESUME, etc.
> > 
> > This API is different from the current ->suspend and ->resume because it
> > applies to situations outside of system suspend (e.g. runtime power
> > management) and has an emphasis on specific device power states. 
> 
> No. It took 2+ years to add at at least system power states. You want
> to build on that, not scratch it and start over.
> 
> 								Pavel

Hi Pavel,

After giving it some serious thought, I've decided that I agree.  I'm
reworking my plans to reflect this.

I was wondering, however, what do you have in mind for adding to pm_message_t?
Also, are you going to use "PMSG_HALT" and/or "PMSG_REBOOT"?

Thanks,
Adam

--===============62954231996558629==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============62954231996558629==--
