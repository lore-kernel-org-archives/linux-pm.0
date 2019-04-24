From: Bart Van Assche <bvanassche@acm.org>
Subject: Re: next-20190408..0418: Suspend/resume problems on Thinkpad X60
Date: Wed, 24 Apr 2019 15:34:57 -0700
Message-ID: <1556145297.161891.143.camel@acm.org>
References: <20190408173928.GB13260@amd> <20190412102812.GA24977@amd>
         <20190423102239.GA15531@amd> <fed0549d-a789-294c-d899-304911106113@acm.org>
         <20190424101711.GB32457@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424101711.GB32457@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, hdegoede@redhat.com, axboe@kernel.dk, linux-ide@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 2019-04-24 at 12:17 +-0200, Pavel Machek wrote:
+AD4 On Tue 2019-04-23 07:09:42, Bart Van Assche wrote:
+AD4 +AD4 On 4/23/19 3:22 AM, Pavel Machek wrote:
+AD4 +AD4 +AD4 +AD4 +AD4 It boots ok (unlike mainline -- I'm debugging that), and I can suspend
+AD4 +AD4 +AD4 +AD4 +AD4 and resume... but then cursor in X is moving and I can talk to
+AD4 +AD4 +AD4 +AD4 +AD4 applications cached in memory, but any access to disk hangs.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 Mainline problem was identified.
+AD4 +AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 +AD4 But resume is still broken. I took advantage of fact that I can still
+AD4 +AD4 +AD4 +AD4 do cached commands, and got complete dmesg. I'm attaching it.
+AD4 +AD4 +AD4 
+AD4 +AD4 +AD4 Still broken in 0418. Ideas would be welcome at this point.
+AD4 +AD4 
+AD4 +AD4 Have you already tried the debugging steps explained in
+AD4 +AD4 Documentation/power to obtain more information about the nature of the
+AD4 +AD4 suspend/resume problem?
+AD4 
+AD4 That won't help, as system resumes ok, then disk hangs.
+AD4 
+AD4 Does it work for you?

Both +ACI-systemctl hibernate+ACI and +ACI-systemctl suspend+ACI work perfectly with the
next-20190424 kernel on my laptop (a Dell Precision laptop).

Bart.
