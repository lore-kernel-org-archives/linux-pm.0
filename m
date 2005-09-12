From: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: Suspended devices and drivers
Date: Sun, 11 Sep 2005 21:33:30 -0500
Message-ID: <200509112133.30359.dtor_core@ameritech.net>
References: <Pine.LNX.4.44L0.0509111507420.9186-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4092715110352303=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0509111507420.9186-100000@netrider.rowland.org>
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
Cc: David Brownell <david-b@pacbell.net>
List-Id: linux-pm@vger.kernel.org

--===============4092715110352303==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 11 September 2005 14:16, Alan Stern wrote:
> 
> So yes, Windows did behave inconsistently with respect to interruptions of 
> Vbus.  But it did not behave inconsistently (to within the limits of its 
> knowledge) with respect to plugging and unplugging.
> 

FWIW it is not inconsistency in windows world it seems. Quite a few
docking stations only support J3 so the normal course of cation is to
suspend, unpug and then, at resume, rfe-enumerate all devices to pick
up the new one and remove ones that were disconnected.

-- 
Dmitry

--===============4092715110352303==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============4092715110352303==--
