From: Nick Davies <nickavies@yahoo.com>
Subject: Freeze the FUSE on Wubi
Date: Fri, 16 Oct 2009 01:54:10 -0700 (PDT)
Message-ID: <814979.58291.qm@web112806.mail.gq1.yahoo.com>
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
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Dear all,

   I am trying to debug the suspend/hibernate on Wubi(The Ubuntu installer for Windows) these day. Since Ubuntu sits on top of NTFS partition with the help of ntfs-3g via FUSE, I think it should not pass the file system freezing stage, but in fact, the suspend works well on my machine. So  I am curious that how can they achieve that? Just keep the FUSE alive to the end of the suspend?
  Any ideas are welcome.

Best regards,
Nick 


      
