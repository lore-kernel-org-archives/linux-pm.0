From: Nigel Cunningham <nigel@tuxonice.net>
Subject: Nigel's current for-rafael queue
Date: Sat, 25 Sep 2010 14:16:42 +1000
Message-ID: <1285388224-10012-1-git-send-email-nigel__4165.45243138007$1285388423$gmane$org@tuxonice.net>
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

Hi Rafael.

Please find attached a slightly updated version of the patchset I sent
a few months ago. The main change is that I've prepended and additional
patch which lets the user see the speed at which the image is being
read and written. This is accomplished by recording the MB/s in a single
byte in the image header, and using a couple of __nosavedata variables
to get the data back through the atomic restore. I realise the char limits
us to 255MB/s at the moment. In future patches, I intend to address this
by storing the data in a 'proper' image header (it's a real problem -
TuxOnIce reads and writes on the same set up at speeds around 250MB/s).

Results on my Dell XPS M1530, which has an SSD hard drive are:

With just patch 1 applied:
Attempt 1: Write 74MB/s; Read 52MB/s
Attempt 2: Write 68MB/s; Read 52MB/s
Attempt 3: Write 73MB/s; Read 53MB/s

With the whole sequence:
Attempt 1: Write 181MB/s; Read 52MB/s
Attempt 2: Write 156MB/s; Read 53MB/s
Attempt 3: Write 160MB/s; Read 52MB/s

Regards,

Nigel
