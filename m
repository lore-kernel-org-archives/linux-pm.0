From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Swsusp patches applied to suspend-2.6#linux-next
Date: Mon, 27 Sep 2010 15:43:35 +1000
Message-ID: <1285566238-10966-1-git-send-email-nigel__29146.7764568099$1285566309$gmane$org@tuxonice.net>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Hi again Rafael.

As discussed, here are the patches, modified to apply against your current
linux-next tree. A new first patch splits compression support out into its
own file, removing the need to have two versions of the load_image and
save_image routines, minimising the changes to the remainder of the
patches and making things cleaner than would otherwise be the case.

On my laptop, single-threaded compression actually slows writing down from
175MB/s to around 100-120MB/s (depending on how well the image compresses).
Reading speed improves from 218MB/s to around 245MB/s. I expect that
multithreaded writing would bring the writing (and reading) speeds back
up. It's on my swsusp to do list :)

Nigel
