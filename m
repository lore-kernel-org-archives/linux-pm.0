From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
Date: Wed, 29 Jan 2014 10:29:56 -0800
Message-ID: <20140129182956.14275.72264@capellas-linux>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
 <20131003214246.24540.99218@capellas-linux>
 <20131003234735.19051.84583@capellas-linux>
 <20131010175010.17870.58060@capellas-linux>
 <20131022175414.14753.58063@capellas-linux>
 <20140128185926.5312.36635@capellas-linux>
 <20140128125442.4bac748945b404179deb58ba@linux-foundation.org>
 <20140128205830.14275.80319@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140128205830.14275.80319@capellas-linux>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Capella <sebastian.capella@linaro.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge.hallyn@canonical.com>, linaro-kernel@lists.linaro.org, Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@linaro.org, "Rafael J.  Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Hi Andrew,

By the way, I do see a call (sysfs_streq) in use for this purpose
other places.  Sorry, I didn't find it while looking at the original
problem.  I'm not sure if this is preferable, but it appears to have
been added specifically for the strings coming through sysfs.

My preference is copying the string and cleaning it up before passing
it to internal functions, even though we incur an allocation.

Thanks,

Sebastian
