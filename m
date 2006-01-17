From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Query regarding behavior of PCMCIA devices with
	respect to suspend and resume
Date: Tue, 17 Jan 2006 09:57:31 +0100
Message-ID: <20060117085731.GA4726@isilmar.linta.de>
References: <05B7784238A51247A0A9FB4B348CECAE014CEACE@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73761362953779996=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <05B7784238A51247A0A9FB4B348CECAE014CEACE@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: kaustav.majumdar@wipro.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============73761362953779996==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jan 17, 2006 at 02:12:20PM +0530, kaustav.majumdar@wipro.com wrote:
> I am new to linux power management.... I had seen some PCMCIA client
> drivers, where in the event handler for events CARD_SUSPEND and
> CARD_RESUME nothing generic had been done but those events ultimately
> causes release and get configuration only.....

Exactly; and that's why this even gets moved into the upper layer for
2.6.17:
http://kernel.org/git/?p=linux/kernel/git/brodo/pcmcia-2.6.git;a=commit;h=66b91eb48d18d4781bddcf8f0ac872e2405903fc

> So does that mean the expected behavior from any PCMCIA device in case
> of suspend/resume activity is to release its configurations on
> suspension and getting new configuration without actually resuming the
> task the device was performing at the time of suspension???

Well, most PCMCIA drivers are "dumb" in this regard -- but, for example, the
net drivers do stop the queue and restart it on suspend and resume. To do it
properly, you do need to stop all activity in the .suspend() callback and
continue processing it in or after .resume()

	Dominik

--===============73761362953779996==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73761362953779996==--
