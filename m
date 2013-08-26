From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
Date: Mon, 26 Aug 2013 10:40:50 -0700
Message-ID: <20130826174050.16429.7419@capellas-linux>
References: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
 <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
 <20130825153811.GA4795@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130825153811.GA4795@amd.pavel.ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: len.brown@intel.com, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Apologies for my previous top post reply...

Quoting Pavel Machek (2013-08-25 08:38:11)
> Is the allocation actually neccessary? At the very least this should
> test for NULL...


Thanks Pavel!  I'll add the check for NULL.

name_to_dev_t expects a non-const name, but the buffer passed in
is const.  I also am removing the '\n' if found at the end of the
string which would violate the const.

Thanks!

Sebastian
