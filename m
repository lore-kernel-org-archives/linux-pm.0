From: Willi Mann <foss-ml@wm1.at>
Subject: kernel 2.6.32 much slower than 2.6.31 on s2disk
Date: Wed, 16 Dec 2009 17:10:46 +0100
Message-ID: <hgb0q7$u8a$1@ger.gmane.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

It seems to me that kernel 2.6.32 takes much longer to restore the system 
into a really responsive state, despite the fact that s2disk seems to finish 
much faster. 

I don't know to how to do a reliable benchmark on this problem, espially as 
the required time probably very much depends on the exact state of the 
frozen system. Is there any change in 2.6.32 that might cause less memory to 
be stored on the suspend device, and thus require more random disk access 
after the restore?

WM
