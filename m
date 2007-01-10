From: Rob Walker <rob@tenfoot.org.uk>
Subject: Suspend and wake on lan
Date: Wed, 10 Jan 2007 20:50:25 +0000
Message-ID: <200701102050.25410.rob@tenfoot.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <suspend-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=suspend-devel>
List-Post: <mailto:suspend-devel@lists.sourceforge.net>
List-Help: <mailto:suspend-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/suspend-devel>,
	<mailto:suspend-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: suspend-devel-bounces@lists.sourceforge.net
Errors-To: suspend-devel-bounces@lists.sourceforge.net
To: linux-pm@lists.osdl.org, suspend-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi,

I'm having some trouble getting wake on lan to work after the computer is 
suspended.  Wake on Lan works if I shut down the computer normally (i.e. it 
powers up again when I send the magic packet), but doesn't wake up when I 
suspend the computer to disk and then send the magic packet.  I ensure that 
wake on lan is enabled before suspending by running `ethtool -s eth0 wol g`.

The computer is an AMD Athlon, using a Gigabyte GA-71X motherboard with VIA 
KT400 chipset.
The on board network chip is a RealTek RTL8139, using the 8139too driver.

I've tried the kernel from debian testing (2.6.18) and a hand built 2.6.19.1 
kernel, both with the same results.  

I've tried uswsusp and the in-kernel suspend, again both with the same 
results.

Can you help?

Regards

Rob

-- 
Rob Walker <rob@tenfoot.org.uk>
http://www.tenfoot.org.uk

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
