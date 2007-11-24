From: Ben Liblit <liblit@cs.wisc.edu>
Subject: cannot resume using USB keyboard/mouse
Date: Sat, 24 Nov 2007 00:15:05 -0600
Message-ID: <4747C169.10807@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090002080202080407070400"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------090002080202080407070400
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

When I suspend my desktop box, I cannot resume again by pressing a key 
on my USB keyboard or clicking a button on my USB mouse.  I have to 
press the chassis power button to wake things up again.  (I'd expect 
this to be necessary after hibernation, but not after suspend.)  The 
same machine resumes from suspend using keyboard or mouse buttons under 
Vista, so I know this is something that the hardware is capable of.

Is this a bug?  Or is there some local configuration tweak I should be 
making to tell the system to wake up in response to USB key presses & 
mouse clicks?

I'm running Fedora 8, with a Fedora-provided kernel version 
2.6.23.1-49.fc8.  Attached below is a pruned-down hardware description 
(from lshw) showing the mouse and keyboard, plus other buses and bridges 
by which they are connected.  Are there any other useful details I can 
provide?

Thanks!

-- Ben

--------------090002080202080407070400
Content-Type: text/plain;
 name="lshw-pruned.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lshw-pruned.txt"

H/W path             Device      Class          Description
===========================================================
                                 system         Nobilis
/0                               bus            DG965RY
/0/100                           bridge         82P965/G965 Memory Controller Hub
/0/100/1d                        bus            82801H (ICH8 Family) USB UHCI Controller #1
/0/100/1d/1          usb5        bus            UHCI Host Controller
/0/100/1d/1/2                    bus            TUSB2040/2070 Hub
/0/100/1d/1/2/1                  generic        Microsoft Natural Keyboard Pro
/0/100/1d/1/2/2                  generic        Microsoft IntelliMouse


--------------090002080202080407070400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090002080202080407070400--
