From: simon polette <spolette@gmail.com>
Subject: Any solution for suspend to disk on ARM devices ?
Date: Tue, 14 Apr 2009 10:41:55 +0200
Message-ID: <72795ccb0904140141n1fb38f23y29539be25e0f1e22@mail.gmail.com>
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

Hi,

I'm working on an AT91SAM9261 board and I'm searching solution to
implement suspend to disk. I found some information and patches for a
2.6.11 kernel which is not compatible with my device. I heard about 3
way to implement suspend to disk with linux kernel which are swsusp,
uswsusp and tux on ice, but according this table :
http://www.tuxonice.net/features , they are not compatible with arm.
Do you know if any patch exists, or do you know any other solution to
my problem?
Any idea is welcome.
Best regards,

Simon Polette
