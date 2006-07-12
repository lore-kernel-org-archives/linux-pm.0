From: David Brownell <david-b@pacbell.net>
Subject: Fwd: [RFC] SnapshotBoot for OSK5912
Date: Tue, 11 Jul 2006 17:26:45 -0700
Message-ID: <200607111726.45412.david-b@pacbell.net>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

I think various linux-PM folk might be interested in this, not
just ARM and OMAP folk.  I've not looked at it much yet; note
that it's using a 2.6.11 kernel (vs the latest OMAP kernel) and
relies on updated boot loader firmware.

- Dave

p.s. OSK is a small OMAP1 development board:

http://tree.celinuxforum.org/CelfPubWiki/OSK


----------  Forwarded Message  ----------

Subject: [RFC] SnapshotBoot for OSK5912
Date: Tuesday 11 July 2006 4:03 am
From: Hiroki Kaminaga <kaminaga@sm.sony.co.jp>
To: linux-arm-kernel@lists.arm.linux.org.uk

Hi,

I made a page describing snapshot boot. Patch and instructions are
available here:

http://tree.celinuxforum.org/CelfPubWiki/SuspendToDiskForARM

Snapshot boot is essentially a resume-from-disk operation, which is a
system resume from a semi-permanent snapshot image stored on flash
memory for OSK5912, that restores the machine to a known running
state. As opposed to a standard resume operation, a snapshot image is
made only once, stored on flash memory, and same image is used
repeatedly, every time the system is powered on.

The purpose of this is to achieve faster startup time of linux on
OSK5912. It is still OSK5912 specific, but would like to hear
comments.


Best Regards,

(Hiroki Kaminaga)

-------------------------------------------------------
