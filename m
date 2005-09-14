From: Joost Witteveen <joostje@iliana.nl>
Subject: Oops 2.6.14-rc1, AMD Sempton
Date: Thu, 15 Sep 2005 00:09:51 +0200
Message-ID: <43289FAF.5040009@iliana.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
To: linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

The Oops below happend while swsuspending my Sempron laptop. The system 
freezes afterwards.

On 2.6.12.5 this happened very rarely (but when I had all modules 
loaded, it happend more often, so I wrote a little script around the 
swsuspend, removing most modules before the suspend)

I noticed that the freezes occur somewhat more often on 2.6.13, 
2.6.13.1; but on 2.6.14-rc1 it seems the freeze happens just about 
always, even with most modules unloaded.

.config, System.map and the .jpg of the photo I took of the oops can be 
found at:

http://foko.komputilo.org/~joostje/linux/

Stopping tasks: ------------------------------------------------|
Freeing memory... done (25044 pages freed)
swsusp: Need to copy 29618 pages
Error 12 suspending
-----------[ cut here ]--------------
kernel BUG <bad filename>:8680!
invalid operand: 0000 [#1]
PREEMPT
Modules linked in: powernow_k8 processor
CPU:    0
EIP:    0060:[<c0130361>]    Not tainted VLI
EFLAGS: 00010093   (2.6.14-rc1)
EIP is at swsusp_suspend+073/0x92
eax: 00007427   ebx: fffffff4  ecx: 00000c00  edx: c04d52a0
esi: 00000004   edi: c03c9d89  ebp: c03f4ec4  esp: c0e13f04
ds: 007b   es: 007b   ss: 0068
Process sh (pid: 5324, threadinfo=c0e12000 task=c0ccd030)
Stack: 00000000 c0130c1f fffffff0 c012f1fd 00000005 c9114004 c012f311 
00000004
       00000004 cd19d900 cd19d914 c9f0bbc0 c0e13fa4 c017f7ec c03f4ee0 
c9114000
       00000005 00000005 c017f82c ccea5090 cd19d900 00000005 00000005 
c9f0bbc0
Call Trace:
 [<c0130c1f>] pm_suspend_disk+0x3b/0x7f
 [<c012f1fd>] enter_state+0x27/0x59
 [<c012f311>] state_store+0x7f/0x8b
 [<c017f7ec>] flush_write_buffer+0x24/0x28
 [<c017f82c>] sysfs_write_file+0x3c/0x5b
 [<c014be06>] vfs_write+0xa1/0x138
 [<c014bf3c>] sys_write+0x3b/0x64
 [<c0102ca9>] syscall_call+0x7/0xb
Code: 00 e8 a4 88 1b 00 85 c0 89 c3 74 0d 50 68 f3 25 3a c0 e8 78 76 fe 
ff 58 5a e8 7a 88 1b 00 a1 00 b0 45 c0 39 05 08 b0 4b c0 74 02 <0f> 0b 
e8 21 b4 15 00 fb eb 11 fa 6a 01 e8 9d b1 15 00 89 c3 85
 <7> APIC error on CPU0: 80(08)

---------------------------
The text above is hand-copied from the photo I took, there may be erros 
in it, the real photo is here:
http://foko.komputilo.org/~joostje/linux/swsuspend-2.6.14-rc1-1.jpg

-- 
Groetjes
joostje
47d3fcfe28f2a83497e79d9bc7d5087c-4a1ee1fddab4648175518cb4c1c9edb3ed0e89f0
