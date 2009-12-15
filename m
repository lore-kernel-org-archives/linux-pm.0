From: Stefan Seyfried <stefan.seyfried@googlemail.com>
Subject: Re: [PATCH 1/1] Add /sys/power/last_state support
Date: Tue, 15 Dec 2009 09:19:45 +0100
Message-ID: <20091215091945.66b245ed@strolchi.home.s3e.de>
References: <3c192bd846cc4337d9999c6cd66b649232d9561c.1260074113.git.victor.lowther@gmail.com>
	<200912072241.28017.rjw@sisk.pl>
	<7E0E364A-4AC2-4D3B-B7A0-61DC970C9254@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <7E0E364A-4AC2-4D3B-B7A0-61DC970C9254@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Victor Lowther <victor.lowther@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Dec 2009 18:17:36 -0600
Victor Lowther <victor.lowther@gmail.com> wrote:
> On Dec 7, 2009, at 3:41 PM, "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > Can't you just use the error code returned by "echo mem > /sys/power/ 
> > state"?
> 
> I can, now that I know about it - I did not see anything about error  
> codes when scanning the documentation.

Note that "echo" only will return 0 or 1, not a real error code. You'll
need a 5-line C program to get the errno that's returned from the
kernel.
It might be interesting to know *why* it failed (e.g. no swap
partition or not enough space in there).
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
