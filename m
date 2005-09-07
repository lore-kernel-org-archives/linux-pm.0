From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFH] Freeing IRQs on APM-driven suspend
Date: Wed, 7 Sep 2005 22:22:48 +0200
Message-ID: <200509072222.48947.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============20871083704336613=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============20871083704336613==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I hope you remember the problem with the Hugh Dickins' notebook that
freeing an IRQ during APM-driven suspend in the yenta driver made the
box hang solid during resume.

We (Hugh and me) have investigated this a bit further and it turns out that
the problem is related to the sharing of the IRQ between the yenta and
3c59x drivers.  However, it is not enough to free the IRQ in both drivers
on suspend and request it on resume, because the box hangs anyway
(during resume) if the drivers' *_resume() routines are not called in the
right order.  Namely, it evidently is necessary to call the yenta's resume()
before the 3c59x' resume() so that the box does not hang.

Could you please advise me what may be the reason of this behavior and
what can be done to prevent it?

Greetings,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============20871083704336613==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============20871083704336613==--
