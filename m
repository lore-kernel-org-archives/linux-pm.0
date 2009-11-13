From: Radu Pop <radu.pop@gmail.com>
Subject: suspend to ram + ac adapter
Date: Fri, 13 Nov 2009 16:43:29 +0200
Message-ID: <4AFD7091.2030506@gmail.com>
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

Hello,

The following issue arises on a hp 6715b noteboook running slackware 13:

1. I suspend to ram from xfce, with the notebook connected to ac power.
2. Suspend works fine, once suspended, I pull out the ac power cord.
3. I briefly press the power button in order to resume from suspend to ram.
4. I get a blank screen and an unresponsive system to the point I have 
to power down by pressing and keeping pressed the power button for a few 
seconds (a hard shutdown). Of course, if I didn't remove the ac cord 
before resuming from suspend to ram, this wouldn't happen.

Now, I have tried to find some debugging data that could possibly help 
me on this, but everything is plain dead after my resume attempt, 
neither hal, udev or varios acpi and kernel debugging setups log 
anything to /var/log/messages.

In the hope that anyone can shed some light on this, I would like to 
thank you in anticipation.

Kind regards,
Radu
