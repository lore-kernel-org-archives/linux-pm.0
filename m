From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: suspend/resume of pcmcia
Date: Tue, 28 Feb 2006 09:53:08 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602280951450.4892-100000@iolanthe.rowland.org>
References: <380D9721A8E2114485644D71E87C6AB2016FF52A@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76635210701613121=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB2016FF52A@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============76635210701613121==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 28 Feb 2006 rasmit.ranjan@wipro.com wrote:

> Hi,
>     For pci based host controller when we do global suspend it is the PM
> sub-system which takes care of the sequence of suspend i.e. PM traverses
> the device tree and suspends the child devices first and subsequently
> suspends the controller.
> I have a pcmcia based host controller what i mean is i have a pcmcia
> card which has a usb host controller. Now two things come to picture.
> One is the client driver and other is the HCD. The client driver
> receives a suspend event when i suspend the card by pccardctl suspend.
> In this case ther is no mechanism provided to communicate to the HCD
> about the suspned which has to handled by the user i.e. the client
> driver and hcd. Now if i do global suspend, is it the PM sub-system
> which takes care of the suspend sequence ?

Yes.

> Here what i mean is PM will
> traverse the device tree, it suspends the child devices, then it
> suspends the controller and finally sends the suspend event to the
> client driver or only the suspend event is sent to the client driver
> with out suspendung the controller. 

The PM subsystem sends suspend messages to every driver in the device 
tree.

>         In case of resume, when i resume the card by pccardctl resume (
> not global ), only the resume event of the client driver is getting
> called thats all. So here again the user has to take care of resuming
> the hcd. So for the global resume does PM sub-system take care of
> sending the resume event to the client driver and as well as resuming
> the controller ?

Yes.

Alan Stern


--===============76635210701613121==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76635210701613121==--
