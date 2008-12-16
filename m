From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hibernation bug - swap goes AWOL
Date: Tue, 16 Dec 2008 22:06:53 +0100
Message-ID: <200812162206.53744.rjw__5711.92293796248$1229461874$gmane$org@sisk.pl>
References: <4947ED8C.1010709@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4947ED8C.1010709@tuffmail.co.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 16 of December 2008, Alan Jenkins wrote:
> This is on 2.6.27-rc9.  I can easily test patches, or a more recent
> kernel version.
> 
> I think I've run across a bug in hibernation.  Steps to reproduce:
> 
> 1) Conspire to ensure insufficient swap space for hibernation
> 2) Attempt to hibernate, and fail
> 3) Attempt to hibernate *again*, and fail
> 4) try swapoff

> Outcome:
> 
> # swapoff /dev/sda6
> swapoff: /dev/sda6: Invalid argument
> # cat /proc/swaps
> Filename                                Type            Size    Used   
> Priority
> /dev/sda6                               partition       1494004 1350564 -1
> 
> Incidentally "swapoff -a" fails silently, which I think is a bug in
> swapoff (i.e. it should report the error).
> 
> I don't see any backtraces in dmesg; the only errors it shows is the
> failure to hibernate
> 
> If I free up some memory and try to hibernate again, I get a different
> error - "Cannot find swap device, try swapon -a.".  Now swapon -a
> doesn't work, but if I target the specific device...
> 
> # swapon /dev/sda6
> # cat /proc/swaps
> Filename                                Type            Size    Used   
> Priority
> /dev/sda6                               partition       1494004 331060  -1
> /dev/sda6                               partition       1494004 0       -2
> 
> Wheee!  Interestingly I can now hibernate and resume.  But it's not
> safe; my desktop session dies horribly.

Well, I'm not sure if the bug is in the hibernate code or in the swap code.

Anyway, please file a bugzilla report about that.

Thanks,
Rafael
