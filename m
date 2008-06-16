From: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Problem on Suspend to RAM vs ext3
Date: Mon, 16 Jun 2008 08:50:38 +0200
Message-ID: <48560D3E.8060303@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi all
I have a problem whit my embedded system on kernel 2.6.23.17.
When I call more and more time the suspend on memory than (some time)
 the root file system on ext3 has some problem during the resume.
With google I understood it's a known issue but I didn't understand if 
there is a solution.
Could you give me an help?
Thanks
Regards
 Francesco

P.S.: here the dmesf I have:

sd 0:0:1:0: [sda] Starting disk
ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata1.01: cmd 40/00:01:00:00:00/00:00:00:00:00/f0 tag 0 cdb 0x0 data 0
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata1: port is slow to respond, please be patient (Status 0xd0)
ata1: device not ready (errno=-16), forcing hardreset
ata1: soft resetting port
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x3)
ata1.01: revalidation failed (errno=-5)
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x3)
ata1.01: revalidation failed (errno=-5)
ata1.01: limiting speed to UDMA7:PIO5
ata1: failed to recover some devices, retrying in 5 secs
ata1: soft resetting port
ata1.01: failed to IDENTIFY (I/O error, err_mask=0x3)
ata1.01: revalidation failed (errno=-5)
ata1.01: disabled
ata1: EH pending after completion, repeating EH (cnt=4)
ata1: soft resetting port
ata1: EH complete
sd 0:0:1:0: [sda] START_STOP FAILED
sd 0:0:1:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
Restarting tasks ... done.
sd 0:0:1:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 6042767
Buffer I/O error on device sda1, logical block 755338
lost page write due to I/O error on sda1
sd 0:0:1:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 6042927
Buffer I/O error on device sda1, logical block 755358
lost page write due to I/O error on sda1
sd 0:0:1:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 6042839
Buffer I/O error on device sda1, logical block 755347
lost page write due to I/O error on sda1
Aborting journal on device sda1.
ext3_abort called.
EXT3-fs error (device sda1): ext3_journal_start_sb: Detected aborted journal
Remounting filesystem read-only
sd 0:0:1:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 5767247
Buffer I/O error on device sda1, logical block 720898
lost page write due to I/O error on sda1
sd 0:0:1:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
end_request: I/O error, dev sda, sector 7140655
