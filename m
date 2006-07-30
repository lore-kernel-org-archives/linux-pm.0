From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: Re: [RFC] PowerOP Take 3, ARM OMAP1 PM Core 4/5
Date: Sun, 30 Jul 2006 16:46:56 +0400
Message-ID: <acd2a5930607300546x39676898vc2c1cca26175ebb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Eugeny,

what about possible endless recursion in your implementation of
omap_pm_core_set_opt routine, if, say, DSP PLL needs re-init and DSP
rate won't be successfully set w/o that reinit?

Vitaly
