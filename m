From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: Query regarding behavior of PCMCIA devices with
	respect to suspend and resume
Date: Tue, 17 Jan 2006 20:40:32 +0100
Message-ID: <20060117194032.GA16217@isilmar.linta.de>
References: <05B7784238A51247A0A9FB4B348CECAE014CEC10@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============56152908581400007=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <05B7784238A51247A0A9FB4B348CECAE014CEC10@PNE-HJN-MBX01.wipro.com>
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

--===============56152908581400007==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Tue, Jan 17, 2006 at 06:49:11PM +0530, kaustav.majumdar@wipro.com wrote:
> If in a PCMCIA device, there will be a USB port, then suspend/resume can
> be or will be handled by controller for that USB port.

If that driver supports a suspend and resume method, then yes, it will be
handled automatically as the PCMCIA subsystem is fully integrated into the
Linux kernel device model infrastructuire.

> But I am not sure
> whether in that case, the PCMCIA client driver should support the HCD or
> not and if yes then in what way?

What do you mean with this? What do you mean with "HCD"?

	Domninik

--===============56152908581400007==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============56152908581400007==--
