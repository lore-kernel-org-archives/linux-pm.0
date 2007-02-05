From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH/RFC 00/10] suspend to disk for powermac G5
Date: Mon, 05 Feb 2007 19:30:27 +0100
Message-ID: <20070205183026.989209000@sipsolutions.net>
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
To: linuxppc-dev@ozlabs.org
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi!

Here's my latest patchset for suspend to disk on powermac. It also contains
a whole bunch of cleanups and fixes in various other places some of which
are CCed to Andrew (who will hopefully put them into -mm).

Other than that, thanks to the mpic resume/suspend code it appears to work
quite well. Thanks to Michael Buesch for testing with PREEMPT enabled which
uncovered another bug with cpu "hotplug" (where I still don't understand why
the preempt_count is messed up on resume but not when I put a CPU off- and
online via sysfs.)

To actually get proper suspend for a G5 powermac with an Onyx codec you need
to apply the patch at http://patchwork.ozlabs.org/linuxppc/patch?id=3D8683

Any comments are appreciated, especially on the patch that actually
implements the snapshot code ("powermac: suspend to disk on G5.")

johannes
