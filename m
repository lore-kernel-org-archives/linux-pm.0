From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [GIT PULL] interconnect changes for v5.2-rc1
Date: Thu, 25 Apr 2019 14:25:55 +0300
Message-ID: <eafe23a5-e3cd-760d-f3f0-c82b50e78417@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Greg,

This is a tiny pull request with interconnect patches for the 5.2 merge window.
The patches have spent a few weeks in linux-next without reported issues. The
details are in the signed tag. Please consider pulling into char-misc-next.

Thanks,
Georgi

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.2-rc1

for you to fetch changes up to 83fdb2dfb0c2925f253449677830ed11461ac5c8:

  interconnect: convert to DEFINE_SHOW_ATTRIBUTE (2019-04-06 22:03:03 +0700)

----------------------------------------------------------------
interconnect: for 5.2

Here are some tiny patches for the 5.2-rc1 merge window:

- Add linux-pm@ as a mailing list for the interconnect API.
- Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

----------------------------------------------------------------
Georgi Djakov (1):
      MAINTAINERS: Add mailing list for the interconnect API

Yangtao Li (1):
      interconnect: convert to DEFINE_SHOW_ATTRIBUTE

 MAINTAINERS                 |  1 +
 drivers/interconnect/core.c | 13 +------------
 2 files changed, 2 insertions(+), 12 deletions(-)
