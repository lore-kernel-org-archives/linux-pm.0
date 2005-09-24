From: Alan Stern <stern@rowland.harvard.edu>
Subject: Problems with PM_FREEZE
Date: Fri, 23 Sep 2005 22:09:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0509232155380.23428-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============033837837450140462=="
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

--===============033837837450140462==
Content-Type: TEXT/PLAIN; charset=US-ASCII

A problem with the PM_FREEZE state has surfaced recently.

It has to do with the device state recorded in the memory image.  When the 
image is made, devices are in the FREEZE state, and that's what gets 
recorded.  But then the image is written to disk and devices are put into 
SUSPEND.

Later on, when the system wakes up and the image is restored, drivers are 
asked to resume the devices.  The problem is that now the drivers think 
the devices are in FREEZE when in fact they are really in SUSPEND.  The 
difference is significant and it can cause errors in the resume procedure.

What's the correct way to handle this?  On possible solution would be to
let drivers know when a resume call is returning from a system sleep.  
When that happens drivers can safely assume that the devices really are
in SUSPEND, no matter what the recorded states say.


Here's another, slightly more far-fetched problem.  I don't know if this 
can come up in actual practice.

When a disk device is put in FREEZE, there may be pending write requests
in its I/O queue.  After the image has been made, the device is resumed in
order to write the image to a swap partition.  When that happens the I/O
queue will start running again, briefly.  Those pending writes will be 
carried out.

Then when the system wakes up, the pending requests will be restored along
with the rest of the image.  But they have already been recorded on the
disk.  I can imagine that with some kinds of filesystem this might lead to
an error (although I don't know how).


Any comments?

Alan Stern


--===============033837837450140462==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============033837837450140462==--
