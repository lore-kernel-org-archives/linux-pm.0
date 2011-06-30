From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [REGRESSION] suspend/resume broken on T510
Date: Fri, 1 Jul 2011 00:07:27 +0200
Message-ID: <201107010007.27588.rjw__5975.42784312299$1309471654$gmane$org@sisk.pl>
References: <20110630220050.GB30291@marc.osknowledge.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110630220050.GB30291@marc.osknowledge.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marc Koschewski <marc@osknowledge.org>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Friday, July 01, 2011, Marc Koschewski wrote:
> Hi guys,
> 
> I just thought to wait some what longer than -rc3 to report: suspend/resume is
> broken in the current git. I blacklisted the 'mei' module so the suspend worked
> as of rc4 (last 'first tested and working' version) with knowledge of the
> mei-bug.
> 
> However, my system does not resume anymore on my T510. After suspend the 'moon'
> turns on as usual on 3.0.0-git and the box sleeps. After opening the lid it somehow
> wakes up but doesn't boot/resume. It just stalls after some HDD activity.
> 
> If have no idea what it could be - and I unfortunately cannot bisect it down to
> anything > 2.6.39. I left out rc1 and rc2 this time due to having no time to
> experiment this month. However, my .config is attached if anyone needs it...

Well, perhaps let us know the hardware configuration (attach dmesg?).

Anyway, I'm not sure if there's anyone who can figure out what _may_ be wrong
on the basis of your description alone.  It would be good if you could file
a bug in http://bugzilla.kernel.org and let me know its number.

Thanks,
Rafael
