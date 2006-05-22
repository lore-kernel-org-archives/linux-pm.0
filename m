From: David Brownell <david-b@pacbell.net>
Subject: Re: Ejecting/Powering off/ -> Turn off the device lamp.
Date: Mon, 22 May 2006 10:03:58 -0700
Message-ID: <200605221003.59827.david-b@pacbell.net>
References: <4471E520.1090008@techmoninc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31101708136102113=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <4471E520.1090008@techmoninc.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Andy Kennedy <akennedy@techmoninc.com>
List-Id: linux-pm@vger.kernel.org

--===============31101708136102113==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 22 May 2006 9:21 am, Andy Kennedy wrote:

> Is there a way to signal the device to stop the cycle and actually power 
> off the LED?

You might be able to ask the device to suspend -- using the deprecated
/sys/devices/.../power/state files -- which in common cases means that
bus-powered devices won't be able to keep a LED powered.

But LEDs are highly device-specific, so there can be no general rules.

- Dave

--===============31101708136102113==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31101708136102113==--
