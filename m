From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Nigel's current for-rafael queue
Date: Sun, 26 Sep 2010 00:19:37 +0200
Message-ID: <201009260019.37438.rjw__5344.05894945866$1285453343$gmane$org@sisk.pl>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

On Saturday, September 25, 2010, Nigel Cunningham wrote:
> Hi Rafael.

Hi Nigel,

> Please find attached a slightly updated version of the patchset I sent
> a few months ago. The main change is that I've prepended and additional
> patch which lets the user see the speed at which the image is being
> read and written. This is accomplished by recording the MB/s in a single
> byte in the image header, and using a couple of __nosavedata variables
> to get the data back through the atomic restore. I realise the char limits
> us to 255MB/s at the moment. In future patches, I intend to address this
> by storing the data in a 'proper' image header (it's a real problem -
> TuxOnIce reads and writes on the same set up at speeds around 250MB/s).
> 
> Results on my Dell XPS M1530, which has an SSD hard drive are:
> 
> With just patch 1 applied:
> Attempt 1: Write 74MB/s; Read 52MB/s
> Attempt 2: Write 68MB/s; Read 52MB/s
> Attempt 3: Write 73MB/s; Read 53MB/s
> 
> With the whole sequence:
> Attempt 1: Write 181MB/s; Read 52MB/s
> Attempt 2: Write 156MB/s; Read 53MB/s
> Attempt 3: Write 160MB/s; Read 52MB/s

Thanks for the patches, they look like a real improvement to me.

I only had a couple of minor comments, sent separately in replies to individual
patches.  I'd like to push this series for 2.6.37, if the comments are
addressed timely.

Best regards,
Rafael
