From: "Vitaly Wool" <vitalywool@gmail.com>
Subject: PowerOp Core/sysfs question
Date: Sun, 30 Jul 2006 17:10:27 +0400
Message-ID: <acd2a5930607300610x55f2d61alb4ea4430bb95affd@mail.gmail.com>
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

can you please elaborate a bit on the rationale for exposing the
struct powerop_point to the core/sysfs interface? Why not make it an
inner structure to the board?
Including asm/powerop.h which includes asm/arch/powerop.h seems a bit
of modularity principle violation to me.

Thanks,
   Vitaly
