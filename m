From: Mohan <camilo.id@gmail.com>
Subject: Question regarding kjournald when entering hibernation
Date: Fri, 11 Nov 2011 17:35:07 +0900
Message-ID: <CACzi5T9Df+h4eG_yabUt4sU5V=W+6gvVWODk90FzkX1jH=BhUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

I am testing hibernation on a PPC4xx board.
I have noticed that kjournald is still running even when the hibernation
image is being saved to disk.

On looking at the code in fs/jbd/journal.c the kjournald thread
has a check "if(freezing(current))" which i assume is to
check if hibernating and to freeze the kjournald thread.
But since the kjournald thread has the PF_NOFREEZE flag
set it does not freeze the kjournald thread.

1. Can any one tell me in what case the kjournald thread is frozen?
2. Or is there no problem if it is not frozen during hibernation ?
3. Would it be a bad idea to set the kjournald thread freezeable using
"set_freezable()" ?

Thank you,
Mohan
