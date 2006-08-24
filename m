From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: PowerOP, Whatchanged/Issues/TODO 3/3
Date: Thu, 24 Aug 2006 05:15:15 +0400
Message-ID: <44ECFDA3.9060701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
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
To: pm list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

whatchanged:
- interface to get list of registered operating point names is added
- notification callbacks interface on point registration/unregistration is
added
- registration of a point with duplicated name fix

todo/issues:
- better implementation for for getting registered operating point names
- move string parsing into powerop generic code
- power parameter names export
- configfs for operating points creation from user space
