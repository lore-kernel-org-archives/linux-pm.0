From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC/RFT][PATCH 0/2] swsusp: improve freeing of memory
Date: Tue, 8 Nov 2005 23:55:43 +0100
Message-ID: <200511082355.43984.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============46141633966952278=="
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
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============46141633966952278==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The following two patches are designed to make swsusp free only as much
memory as needed for suspend and not as much as possible.  This speeds
up the suspend and resume significantly and causes the system to be much
more responsive after resume.

The essential changes are in the second patch.  However, to make it work
properly on x86-64 it is necessary to get rid of the suspend image size limit
imposed by the size of the swsusp_info structure.  Of course this can be done
in many different ways, but I think it is reasonable to do this in a way which
will allow us to further separate the image-handling and swap-handling
functionalities of swsusp in the future.  Thus I propose to introduce a
separate data structure for handling the swap and to remove the swap-related
fields from the PBEs, which is done in the first patch.

The proposed approach yields some additional benefits, like the following:
1) the amount memory needed to store the list of PBEs (aka pagedir) is
reduced by 1/4,
2) the amount of swap needed to store the image metadata is reduced by 1/2,
3) there's more memory available during suspend (the data structure used
for keepeng track of the data pages written to the swap need not be loaded
into memory during suspend),
4) the size of swsusp_info structure is reduced so it can be merged with the
swsusp_header structure in the future,
5) the swap-handling part need not use any global variables related to the
snapshot data structure,
6) the use of __nosavedata variables is reduced significantly.

The patches are on top of 2.6.14-mm1 with the three additional patches of mine
that went to Andrew after 2.6.14-mm1.  For your convenience the whole
series of patches is available at:

http://www.sisk.pl/kernel/patches/2.6.14-mm1/

as:

swsusp-reduce-code-duplication.patch
swsusp-improve-relocation.patch
swsusp-rework-swsusp_suspend.patch
swsusp-introduce-swap-map.patch
swsusp-improve-freeing-memory.patch

and should be applied in that order.

The patches have been being tested on my box (Asus L5D, x86-64 "mode") for
quite some time, but I haven't tested all of the error paths and the image
encryption.

I would appreciate it very much if you could review the patches and send me
any comments and/or suggestions.  Also I would be grateful if you could test
them, although please note they are not indended for the production use
(yet).

Greetings,
Rafael


--===============46141633966952278==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46141633966952278==--
